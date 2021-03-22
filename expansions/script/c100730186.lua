--高速决斗技能-场地更变
Duel.LoadScript("speed_duel_common.lua")
function c100730186.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730186.skill,c100730186.con,aux.Stringid(100730186,0))
	aux.SpeedDuelMoveCardToFieldCommon(25518020,c)
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730186.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_ONFIELD,0,1,nil,TYPE_EQUIP)
		and Duel.IsPlayerCanDraw(tp,1)
		and Duel.GetLP(tp)<=6000
end
function c100730186.skill(e,tp,eg,ep,ev,re,r,rp,chk)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730186)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_ONFIELD,0,nil)
	if chk==0 then return g:CheckSubGroup(c100730186.fselect,2,2) end
	local rg=g:SelectSubGroup(tp,c100730186.fselect,false,1,2)
	Duel.SendtoGrave(rg,REASON_EFFECT)
	local ct=rg:GetCount()
	Duel.Draw(tp,ct,REASON_RULE)
	e:Reset()
end

function c100730186.fselect(g)
	return g:IsExists(Card.IsType,1,nil,TYPE_EQUIP)
end