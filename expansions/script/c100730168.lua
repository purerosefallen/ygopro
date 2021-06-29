--高速决斗技能-抽卡预感：风
Duel.LoadScript("speed_duel_common.lua")
function c100730168.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(26022485,c)
	if not c100730168.UsedLP then
		c100730168.UsedLP={}
		c100730168.UsedLP[0]=0
		c100730168.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730168.skill,c100730168.con,aux.Stringid(100730168,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730168.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730168,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730168)
		c100730168.UsedLP[tp]=c100730168.UsedLP[tp]+1500
		local g=Duel.GetMatchingGroup(Card.IsAttribute,tp,LOCATION_DECK,0,nil,ATTRIBUTE_WIND)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730168.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsAttribute,tp,LOCATION_DECK,0,nil,ATTRIBUTE_WIND)>0
		and aux.DecreasedLP[tp]-c100730168.UsedLP[tp] >= 1500
end