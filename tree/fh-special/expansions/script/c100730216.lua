--高速决斗技能-收渔之日
Duel.LoadScript("speed_duel_common.lua")
function c100730216.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730216.skill,c100730216.con,aux.Stringid(100730216,0))
	aux.RegisterSpeedDuelSkillCardCommon()
	aux.SpeedDuelBeforeDraw(c,c100730216.skill2)
end

function c100730216.Iskai(c)
	return c:IsCode(3643300) and c:IsFaceup()
end

function c100730216.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730216.Iskai,tp,LOCATION_MZONE,0,1,nil)
end

function c100730216.wfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsLevelBelow(4)
end
function c100730216.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730216)
	local d=Duel.CreateToken(tp,22702055)
	local g1=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_FZONE,0,nil,TYPE_FIELD)
	if g1:GetCount()~=0 then
		local g2=Duel.GetMatchingGroup(c100730216.wfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,nil)
		if g2:GetCount()==0 or Duel.GetMZoneCount(tp)==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g2:Select(tp,1,1,nil)
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	else Duel.MoveToField(d,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
	end
end

function c100730216.skill2(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetCategory(CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetValue(c100730216.abdcon)
	e3:SetCondition(c100730216.recon)
	e3:SetOperation(c100730216.reop)
	Duel.RegisterEffect(e3,tp)
	e:Reset()
end
function c100730216.recon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return tc:IsControler(tp) and tc:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER) and tc:IsCode(3643300)
end
function c100730216.reop(e,tp,eg,ep,ev,re,r,rp) 
	local tc=eg:GetFirst() 
	local bc=tc:GetBattleTarget()
	local re=bc:GetAttack()
	if re<0 then re=0 end
	Duel.Recover(tp,re,REASON_EFFECT)
end
function c100730216.abdcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end