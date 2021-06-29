--高速决斗技能--抽卡预感：低星
Duel.LoadScript("speed_duel_common.lua")
function c100730129.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(37231841,c)
	if not c100730129.UsedLP then
		c100730129.UsedLP={}
		c100730129.UsedLP[0]=0
		c100730129.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730129.skill,c100730129.con,aux.Stringid(100730129,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730129.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730129,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730129)
		c100730129.UsedLP[tp]=c100730129.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsLevelBelow,tp,LOCATION_DECK,0,nil,4)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730129.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsLevelBelow,tp,LOCATION_DECK,0,nil,4)>0
		and aux.DecreasedLP[tp]-c100730129.UsedLP[tp] >= 1000
end