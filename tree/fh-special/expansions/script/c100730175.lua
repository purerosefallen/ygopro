--高速决斗技能-命运D
Duel.LoadScript("speed_duel_common.lua")
function c100730175.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730175.skill1,c100730175.con,aux.Stringid(100730175,0))
	aux.RegisterSpeedDuelSkillCardCommon()
	aux.SpeedDuelBeforeDraw(c,c100730175.skill2)
end
function c100730175.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_HAND,0,1,nil,26964762) 
		and Duel.GetTurnCount(tp)>=4
		and Duel.GetLP(tp)<=6000
end
function c100730175.skill1(e,tp,eg,ep,ev,re,r,rp)   
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730175)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,26964762)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	local op=Duel.SelectOption(tp,aux.Stringid(100730175,1),aux.Stringid(100730175,2))
	if op==0 and Duel.GetMZoneCount(1-tp)>0 and Duel.IsPlayerCanDraw(tp,1) then
		Duel.SpecialSummon(tc,0,tp,1-tp,false,false,POS_DEFENSE)
		Duel.Draw(tp,1,REASON_RULE)
	else Duel.SendtoDeck(tc,1-tp,nil,0,REASON_RULE)
	end
end
function c100730175.skill2(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100730175.Dfilter)
	e1:SetValue(c100730175.val)
	Duel.RegisterEffect(e1,tp)
	e:Reset()
end

function c100730175.Dfilter(e,c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsAttackBelow(1500) and c:IsDefenseBelow(1500) and c:IsRace(RACE_WARRIOR)
end

function c100730175.val(e,c)
	return c:GetLevel()*150
end