--高速决斗技能-我也能决斗吗？
Duel.LoadScript("speed_duel_common.lua")
function c100730134.initial_effect(c)
	aux.SpeedDuelBeforeDraw(c,c100730134.skill)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730134.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local count=1
	if Duel.GetTurnPlayer()~=tp then
		count=2
	end
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE_START+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c100730134.con)
	e1:SetReset(RESET_PHASE+PHASE_END,count)
	e1:SetOperation(c100730134.op)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end
function c100730134.filter(c)
	return c:IsRace(RACE_FAIRY) and c:IsStatus(STATUS_SUMMON_TURN)
end

function c100730134.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,100730134)
	Duel.Recover(tp,2000,REASON_EFFECT)
	local d=Duel.CreateToken(tp,29587993)
	local d1=Duel.CreateToken(tp,45667991)
	Duel.SpecialSummon(d1,0,tp,tp,true,true,POS_FACEUP_ATTACK)
	Duel.SpecialSummon(d,0,tp,tp,true,true,POS_FACEUP_DEFENSE)
	local g1=Duel.SelectMatchingCard(tp,Card.IsLevel,tp,LOCATION_MZONE,0,2,2,nil,7)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local c=Duel.CreateToken(tp,92015800)
	Duel.SendtoDeck(c,tp,1,REASON_RULE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_EXTRA,0,1,1,nil,92015800)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=g2:GetFirst()
	if tc then
		Duel.BreakEffect()
		tc:SetMaterial(g1)
		Duel.Overlay(tc,g1)
		Duel.SpecialSummon(tc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		tc:CompleteProcedure()
		local g3=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,0,1,nil,18378582)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		if Duel.GetMZoneCount(tp)<1 or g3:GetCount()==0 then return end
		local sc=g3:GetFirst()
		Duel.SpecialSummon(sc,0,tp,tp,true,true,POS_FACEUP)
	end
end
function c100730134.con(e,tp,eg,ep,ev,re,r,rp)
	if count==2 then return Duel.GetTurnCount()==2 end
	return Duel.IsExistingMatchingCard(c100730134.filter,tp,LOCATION_MZONE,0,1,nil)and Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_SZONE,0,2,nil) and Duel.GetMZoneCount(tp)>1
end
