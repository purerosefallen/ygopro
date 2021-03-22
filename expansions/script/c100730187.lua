--高速决斗技能-场地更变
Duel.LoadScript("speed_duel_common.lua")
function c100730187.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730187.skill,c100730187.con,aux.Stringid(100730187,0))
	aux.SpeedDuelMoveCardToFieldCommon(69112325,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730187.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_ONFIELD,0,1,nil,TYPE_FIELD)
		and Duel.IsPlayerCanDraw(tp,1)
		and Duel.GetLP(tp)<=6000
end
function c100730187.skill(e,tp,eg,ep,ev,re,r,rp,chk)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730187)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_ONFIELD,0,nil)
	if chk==0 then return g:CheckSubGroup(c100730187.fselect,2,2) end
	local rg=g:SelectSubGroup(tp,c100730187.fselect,false,1,2)
	Duel.SendtoDeck(rg,nil,tp,2,REASON_EFFECT)
	local ct=rg:GetCount()
	Duel.Draw(tp,ct,REASON_RULE)
	e:Reset()
end

function c100730187.fselect(g)
	return g:IsExists(Card.IsType,1,nil,TYPE_FIELD)
end